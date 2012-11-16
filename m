Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Nov 2012 13:47:13 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Hard freeze after 'rfkill block bluetooth'
Message-ID: <alpine.LNX.2.00.1211161344430.20577@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I got a hard freeze with HEAD at 1b42fc4 (i.e. past -rc4) after running 
rfkill block bluetooth.

Screen capture can be found at

	http://www.jikos.cz/jikos/junk/IMAG0264.jpg

(sorry for the bad picture quality, but I believe it's readable).

I am not able to reproduce it again.

-- 
Jiri Kosina
SUSE Labs
