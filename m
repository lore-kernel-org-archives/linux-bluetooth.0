Return-Path: <karl.h.beckers@gmx.net>
Subject: Re: Re: [Bluez-users] repairing required after each dialup
From: "Karl H. Beckers" <karl.h.beckers@gmx.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1136576435.17973.1.camel@localhost>
References: <1136566815.17866.2.camel@localhost.localdomain>
	 <1136576435.17973.1.camel@localhost>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:33:40 +0100
Message-Id: <1136630021.20800.1.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-users.lists.sourceforge.net>

Am Freitag, den 06.01.2006, 20:40 +0100 schrieb Marcel Holtmann:
> Hi Karl,
> 
> > attached you'll find the dumps of:
> > 1) me doing "ifdown ppp0" which for some reason also quits rfcomm
> > (hcidump-drop-conn.txt)
> > 2) me trying "rfcomm connect 0" again and getting "Connection refused"
> > (hcidump-conn-refused.txt)
> > 3) same thing this time after deleting the laptop from the phone's list
> > before trying the connect
> > (hcidump-conn-repaired.txt)
> 
> this really looks like a bug in the phone for me. You might wanna ask
> them for a firmware update.
> 
> Regards
> 
> Marcel
> 
> 

Thanks Marcel,

could you elaborate a little on what makes you think so. I suppose I'll
need to substantiate my claim a little more when I turn to SE for a bug
fix.

Thanks,

Karl.
