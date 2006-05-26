Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <44770C9E.1030703@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering sound from WM5.0
 AKU2.0
References: <96B7A15232D6CF42836BFD428AD6B6034E4F64@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E4F64@deexmb01.de.icap.com>
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
Date: Fri, 26 May 2006 08:11:42 -0600

Guido

fyi, I made a change in cvs so we re-ioctl /dev/dsp if during the stream
the sender changes the rate on us. a2recv will print a message if that
happens.

Brad

>> I just updated cvs to dump that info in the set configuration to the
>> screen. I also limited the channel modes we report as available to the
>> two we actually support (mono/stereo).
> 
> The --enable-fixed doesn't help. Will try the new cvs version today and
> attach the output to my next message.
> 
> Guido
> 
> 
> 
> 
> 
> -------------------------------------------------------
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat certifications in
> the hosting industry. Fanatical Support. Click to learn more
> http://sel.as-us.falkag.net/sel?cmd=k&kid7521&bid$8729&dat1642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
