Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4475C969.6050708@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering sound from WM5.0
 AKU2.0
References: <96B7A15232D6CF42836BFD428AD6B6034E4F44@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E4F44@deexmb01.de.icap.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 25 May 2006 09:12:41 -0600

Guido

I had a look at a2recv. In the block after

 case AVDTP_SET_CONFIGURATION

It seems fishy that we're ignoring several of the sbc element settings
like subbands... but then I believe those settings also appear in each
sbc packet. Maybe wm5 is not filling in the packet part correctly.

I just updated cvs to dump that info in the set configuration to the
screen. I also limited the channel modes we report as available to the
two we actually support (mono/stereo).

Brad



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
