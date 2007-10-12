Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <470F4FE8.2080003@access-company.com>
Date: Fri, 12 Oct 2007 12:43:52 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <d89ddf300710110913x709d8010u9eb6f4d70c7fe47c@mail.gmail.com>	<1192120314.6537.43.camel@aeonflux.holtmann.net>	<d89ddf300710110948y2a1b097p823f38a1099c7154@mail.gmail.com>	<1192121581.6537.45.camel@aeonflux.holtmann.net>	<d89ddf300710111011j5c36df76ga1844b56ff3e1f0b@mail.gmail.com>
	<1192123913.6537.48.camel@aeonflux.holtmann.net>
In-Reply-To: <1192123913.6537.48.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------010809070704020203070501"
Subject: Re: [Bluez-devel] sbc analysis code
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010809070704020203070501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Marcel Holtmann wrote:
> Hi Brad,
>
>   
>>>> it is currently in its own autoconf harness but I would just use the one c file.
>>>>         
>>> fix the coding style and send me a version that I can include. I will
>>> take care of the aufoconf/automake magic. Don't mess around with it.
>>>       
>> hmm... indent likes to break lines. Let me know if the loops are
>> nested too deeply.
>>     
> I think your question already gives you my answer, but let me make it
> clear, I don't wanna have too deeply nested loops. Use break and
> continue or put it into separate functions.
Marcel,

This is updated version.
Regards,

Frederic



--------------010809070704020203070501
Content-Type: text/x-csrc;
 name="sbctester.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sbctester.c"

/*                                                                         *
 *   Copyright (C) 2007 by Frederic Dalleau                                *
 *   fdalleau@free.fr                                                      *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

/*

A2DP Test Specification Chapter 4.6 (p 25)
namely SBC codec conformance test
This is a test procedure for SBC

*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <sndfile.h>
#include <math.h>
#include <string.h>

#define MAXCHANNELS 2
#define MAXFRAMESTESTED infostst->frames
#define TSTSAMPLEFACTOR(x) (x)
#define DEFACCURACY 7

void usage()
{
	printf("usage: sbctester <reference.wav> <filetocheck.wav>\t\tCheck sbc decoded file against spec\n");
	printf("usage: sbctester <integer>\t\tTest normalize fonction\n");
	printf("\n");
	printf("Choose a wav file\n");
	printf("Use a reference encoder to encode the wav file\n");
	printf("Use your sbc encoder (sbcenc) to encode the same wav file\n");
	printf("Decode both file using the reference decoder to obtain two new wav files\n");
	printf("run sbctester with these two wav files to get the result\n");
	printf("Test Specification Chapter 4.6 (p 25) namely SBC codec conformance test\n");
	printf("A file called out.csv is generated to use the data in a spread sheet application or database.\n");
	printf("This is a mandatory test case, but alternative methods exists.\n");
}

double sampletobits(short sample16, int verbose)
{
	double bits = 0;
	int i;
	unsigned short bit;

	if (verbose)
		printf("=======> sampletobits(%hd, %04hX)\n", sample16, sample16);

	// Bit 0 is MSB
	if (sample16 < 0)
		bits = -1;

	if (verbose)
		printf("%d", (sample16 < 0) ? 1 : 0);

	// Bit 15 is LSB
	for (i = 1; i < 16; i++) {
		bit = (unsigned short) sample16;
		bit >>= 15 - i;
		bit %= 2;

		if (verbose)
			printf("%d", bit);

		if (bit)
			bits += (1.0 / pow(2.0, i));
	}

	if (verbose)
		printf("\n");
	return bits;
}

int calculate_rms_level(SNDFILE * sndref, SF_INFO * infosref, SNDFILE * sndtst, SF_INFO * infostst, int accuracy, char *csvname)
{
	int i, j, err = 0, verdict = 0;
	short refsample[MAXCHANNELS], tstsample[MAXCHANNELS];
	double refbits, tstbits;
	double rms;
	double rms_accu[MAXCHANNELS];
	double rms_level[MAXCHANNELS];
	double rms_limit = 1.0 / (pow(2.0, accuracy - 1) * pow(12.0, 0.5));
	FILE *csv = NULL;
	int r1, r2;

	if (csvname)
		csv = fopen(csvname, "wt");

	if (csv) {
		fprintf(csv, "num;");
		for (j = 0; j < infostst->channels; j++)
			fprintf(csv, "ref channel %d;tst channel %d;", j, j);
		fprintf(csv, "\r\n");
	}

	sf_seek(sndref, 0, SEEK_SET);
	sf_seek(sndtst, 0, SEEK_SET);
	memset(rms_accu, 0, sizeof(rms_accu));
	memset(rms_level, 0, sizeof(rms_level));

	for (i = 0; i < MAXFRAMESTESTED; i++) {
		if (csv)
			fprintf(csv, "%d;", i);

		r1 = sf_read_short(sndref, refsample, infostst->channels);
		if (r1 != infostst->channels) {
			printf("Failed to read reference data:%s (r1=%d, channels=%d)", sf_strerror(sndref), r1, infostst->channels);
			err = -1;
			goto error;
		}

		r2 = sf_read_short(sndtst, tstsample, infostst->channels);
		if (r2 != infostst->channels) {
			printf("Failed to read test data:%s (r2=%d, channels=%d)\n", sf_strerror(sndtst), r2, infostst->channels);
			err = -1;
			goto error;
		}

		for (j = 0; j < infostst->channels; j++) {
			if (csv)
				fprintf(csv, "%d;%d;", refsample[j], tstsample[j]);

			refbits = sampletobits(refsample[j], 0);
			tstbits = sampletobits(TSTSAMPLEFACTOR(tstsample[j]), 0);

			rms_accu[j] += pow(tstbits - refbits, 2.0);
		}

		if (csv)
			fprintf(csv, "\r\n");
	}

	printf("Limit: %f\n", rms_limit);

	for (j = 0; j < infostst->channels; j++) {
		printf("Channel %d\n", j);
		printf("Accumulated %f\n", rms_accu[j]);
		rms_accu[j] /= (double) infostst->frames;
		printf("Accumulated / %f = %f\n", (double) infostst->frames, rms_accu[j]);
		rms_level[j] = sqrt(rms_accu[j]);
		printf("Level = %f (%f x %f = %f)\n", rms_level[j], rms_level[j], rms_level[j], rms_level[j] * rms_level[j]);
	}

	verdict = 1;
	for (j = 0; j < infostst->channels; j++) {
		printf("Channel %d: %f\n", j, rms_level[j]);

		if (rms_level[j] > rms_limit)
			verdict = 0;
	}

	printf("%s return %d\n", __FUNCTION__, verdict);


      error:

	if (csv)
		fclose(csv);

	return (err < 0) ? err : verdict;
}

int check_sample()
{
	return 0;
}

int check_absolute_diff(SNDFILE * sndref, SF_INFO * infosref, SNDFILE * sndtst, SF_INFO * infostst, int accuracy)
{
	int i, j, err = 0, verdict = 0;
	short refsample[MAXCHANNELS], tstsample[MAXCHANNELS], refmax[MAXCHANNELS], tstmax[MAXCHANNELS];
	double refbits, tstbits;
	double rms_absolute = 1.0 / (pow(2, accuracy - 2));
	double calc_max[MAXCHANNELS];
	int calc_count = 0;
	short r1, r2;
	double cur_diff;

	memset(&refmax, 0, sizeof(refmax));
	memset(&tstmax, 0, sizeof(tstmax));
	memset(&calc_max, 0, sizeof(calc_max));
	memset(&refsample, 0, sizeof(refsample));
	memset(&tstsample, 0, sizeof(tstsample));

	verdict = 1;
	sf_seek(sndref, 0, SEEK_SET);
	sf_seek(sndtst, 0, SEEK_SET);

	printf("Absolute max: %f\n", rms_absolute);
	for (i = 0; i < MAXFRAMESTESTED; i++) {
		r1 = sf_read_short(sndref, refsample, infostst->channels);

		if (r1 != infostst->channels) {
			printf("Failed to read reference data:%s (r1=%d, channels=%d)", sf_strerror(sndref), r1, infostst->channels);
			err = -1;
			goto error;
		}

		r2 = sf_read_short(sndtst, tstsample, infostst->channels);
		if (r2 != infostst->channels) {
			printf("Failed to read test data:%s (r2=%d, channels=%d)\n", sf_strerror(sndtst), r2, infostst->channels);
			err = -1;
			goto error;
		}

		for (j = 0; j < infostst->channels; j++) {
			refbits = sampletobits(refsample[j], 0);
			tstbits = sampletobits(TSTSAMPLEFACTOR(tstsample[j]), 0);

			cur_diff = fabs(tstbits - refbits);

			if (cur_diff > rms_absolute) {
				calc_count++;
				//printf("Channel %d exceeded : fabs(%f - %f) = %f > %f\n", j, tstbits, refbits, cur_diff, rms_absolute);
				verdict = 0;
			}
			if (cur_diff > calc_max[j]) {
				calc_max[j] = cur_diff;
				refmax[j] = refsample[j];
				tstmax[j] = tstsample[j];
			}
		}
	}

	for (j = 0; j < infostst->channels; j++) {
		printf("Calculated max: %f (%hd-%hd=%hd)\n", calc_max[j], tstmax[j], refmax[j], tstmax[j] - refmax[j]);
	}

	printf("%s return %d\n", __FUNCTION__, verdict);

      error:

	return (err < 0) ? err : verdict;
}

int main(int argc, char *argv[])
{
	int err = 0;
	int rms_absolute, pass_rms, pass_absolute, pass, accuracy;
	char *ref;
	char *tst;
	SNDFILE *sndref = NULL;
	SNDFILE *sndtst = NULL;
	SF_INFO infosref;
	SF_INFO infostst;

	if (argc == 2) {
		double db;

		printf("Test sampletobits\n");
		db = sampletobits((short) atoi(argv[1]), 1);
		printf("db = %f\n", db);
		exit(0);
	}

	if (argc < 3) {
		usage();
		exit(1);
	}

	ref = argv[1];
	tst = argv[2];

	// open both files
	printf("opening reference %s\n", ref);

	sndref = sf_open(ref, SFM_READ, &infosref);
	if (!sndref) {
		printf("Failed to open reference file\n");
		err = -1;
		goto error;
	}

	printf("opening testfile %s\n", tst);
	sndtst = sf_open(tst, SFM_READ, &infostst);
	if (!sndtst) {
		printf("Failed to open test file\n");
		err = -1;
		goto error;
	}

	printf("reference:\n\t%d frames,\n\t%d hz,\n\t%d channels\n", (int) infosref.frames, (int) infosref.samplerate, (int) infosref.channels);
	printf("testfile:\n\t%d frames,\n\t%d hz,\n\t%d channels\n", (int) infostst.frames, (int) infostst.samplerate, (int) infostst.channels);

	// check number of channels
	if (infosref.channels > 2 || infostst.channels > 2) {
		printf("Too many channels\n");
		err = -1;
		goto error;
	}
	// compare number of samples
	if (infosref.samplerate != infostst.samplerate || infosref.channels != infostst.channels) {
		printf("Cannot compare files with different charasteristics\n");
		err = -1;
		goto error;
	}

	accuracy = DEFACCURACY;
	printf("Accuracy: %d\n", accuracy);

	// Condition 1 rms level
	pass_rms = calculate_rms_level(sndref, &infosref, sndtst, &infostst, accuracy, "out.csv");

	if (pass_rms < 0) {
		err = pass_rms;
		goto error;
	}
	// Condition 2 absolute difference
	pass_absolute = check_absolute_diff(sndref, &infosref, sndtst, &infostst, accuracy);

	if (pass_absolute < 0) {
		err = pass_absolute;
		goto error;
	}
	// Verdict
	pass = pass_rms && pass_absolute;
	printf("Verdict: %s\n", pass ? "pass" : "fail");

      error:

	if (sndref)
		sf_close(sndref);

	if (sndtst)
		sf_close(sndtst);

	return err;
}

--------------010809070704020203070501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------010809070704020203070501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010809070704020203070501--
