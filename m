Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hci_conn_info struct
References: <5.1.0.14.2.20031009104727.059fba78@unixmail.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20031009104727.059fba78@unixmail.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200310092109.14409.karypid@inf.uth.gr>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 9 Oct 2003 21:09:14 +0300

On Thursday 09 October 2003 20:48, Max Krasnyansky wrote:
> At 10:19 AM 10/9/2003, Alexandros Karypidis wrote:
> >Hi all,
> >
> >I am using hci_conn_info to obtain a list of devices I am connected to. I
> >"stole" the code from looking at what "hcitool con" does. What I want to
> > do now is figure out what the CoD of the peer device is. I would like to
> > do that in a smart way.
> >
> >I tried doing an inquiry for devices, but I never receive the device I am
> >connected to in the returned list of devices! Is this a limitation of
> >Bluetooth or coincidence?
> >
> >In any case, it seems a little silly to scan for devices in order to find
> > out the CoD of a device I am already connected to. Is there a way to
> > achive this?
>
> Actually if you don't specify IREQ_CACHE_FLUSH flag to hci_inquiry() it
> will return cached results and device you're connected too will be on the
> list for sure.

Not so. This presumes that I had previously inquired for information before 
the device connected to me. It is possible that someone may connect to me 
before I have a chance to detect him with an inquiry... :-(

-- 
In theory, there is no difference between theory and practice.
In practice, there is. -- Yogi Berra.

Alexandros Karypidis
University of Thessaly
Computer & Communications Engineering dept.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
