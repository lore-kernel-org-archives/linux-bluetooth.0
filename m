Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1100885959.7213.31.camel@pegasus>
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>
	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus>  <419DB6E1.8000203@xmission.com>
	 <1100864484.7213.19.camel@pegasus>  <419E20C3.7@xmission.com>
	 <1100883199.7213.27.camel@pegasus>  <1100885959.7213.31.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-UnpX4QciL71M7Gzsba1d"
Message-Id: <1100897144.7213.63.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 Nov 2004 21:45:43 +0100


--=-UnpX4QciL71M7Gzsba1d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Brad,

> actually like with the attached patch. Most of the example *.sbc files
> are working. Some of them are not working and this is maybe because the
> frame header information don't matches the SBC configuration. Or maybe
> hcidump is decoding this wrong.

and I figured out what the extra RFCOMM channel 1 on my Aiptek headphone
does. You can simply stream the SBC files over it. The attached program
will do this for you, but actually it only works on streams with two
channels. I don't know what to change to support all test SBC files.

Regards

Marcel


--=-UnpX4QciL71M7Gzsba1d
Content-Disposition: attachment; filename=rcplay.c
Content-Type: text/x-csrc; name=rcplay.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
 *
 *  Stream SBC files over RFCOMM
 *
 *  Copyright (C) 2004  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation;
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
 *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
 *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
 *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
 *  SOFTWARE IS DISCLAIMED.
 *
 */

#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

static int rfcomm_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t channel)
{
	struct sockaddr_rc addr;
	int sk;

	sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
	if (sk < 0)
		return -1;

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, src);
	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		close(sk);
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, dst);
	addr.rc_channel = channel;
	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		close(sk);
		return -1;
	}

	return sk;
}

static int stream_sbc(fd, sk)
{
	unsigned char buf[330];
	int err, len;

	while (1) {
		len = read(fd, buf, sizeof(buf));
		if (len <= 0)
			break;

		err = write(sk, buf, len);
		if (err < 0)
			break;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	bdaddr_t bdaddr;
	int fd, sk;

	if (argc < 3) {
		fprintf(stderr, "Usage: rcplay <bdaddr> <filename>\n");
		exit(1);
	}

	str2ba(argv[1], &bdaddr);

	fd = open(argv[2], O_RDONLY);
	if (fd < 0) {
		perror("Can't open file");
		exit(1);
	}

	sk = rfcomm_connect(BDADDR_ANY, &bdaddr, 1);
	if (sk < 0) {
		perror("Can't open connection");
		close(fd);
		exit(1);
	}

	stream_sbc(fd, sk);

	close(sk);
	close(fd);

	return 0;
}

--=-UnpX4QciL71M7Gzsba1d--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
