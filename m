Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bthid cvs question
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: Florian Echtler <echtler@fs.tum.de>,
   Olivier Bornet <olivier.bornet@smartdata.ch>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FF99466.8080209@csr.com>
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
	 <1071020597.10655.4.camel@pegasus> <20031210080259.GF26896@smartdata.ch>
	 <1071065922.10655.60.camel@pegasus>
	 <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
	 <1071969925.2684.5.camel@pegasus>  <3FF99466.8080209@csr.com>
Content-Type: text/plain
Message-Id: <1073329354.2508.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 05 Jan 2004 20:02:34 +0100

Hi Steven,

> A lot of devices use page scan repetition mode R2 by default as it's the
> lowest power mode.

the most device I have seen are using R1 by default and the only R2 are
my HID devices.

> BlueZ's behaviour is wrong. If you do not know the page scan repetition
> mode of the device you're going to connect to then you must use R2. The
> 1.1 spec does not state this explicitly, but it can be implied.

I am no baseband expert, so let me see if I understand you right. In the
case we don't know the page scan repetition mode we should use R2 in
prefer of R1 or even R0? Does this have disadvantages if the devices is
in R1 or R0 mode? I ask because we found that connecting with R1 by
default gives us a significant page time improvement.

If only R2 makes sense in case that we don't the exact value, somebody
should bring up an errata to the HCI working group ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
