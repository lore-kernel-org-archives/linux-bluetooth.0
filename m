Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 16:58:20 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
To: stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, "Cho, Yu-Chen" <acho@novell.com>,
	Henry-Nicolas Tourneur <henry.nicolas@tourneur.be>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Oliver Neukum <oliver@neukum.name>, "Lee, Chun-Yi" <jlee@suse.com>,
	Greg KH <gregkh@linux-foundation.org>
Subject: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] Add Atheros maryann PIDVID support
Message-ID: <20120412215819.GA15416@burratino>
References: <00c20c839b7ac6f027ab935f8cf0992c93c5f2fd.1329809368.git.acho@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00c20c839b7ac6f027ab935f8cf0992c93c5f2fd.1329809368.git.acho@suse.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

Please consider

 9498ba7a1d38 Bluetooth: Adding USB device 13d3:3375 as an Atheros AR3012
 07c0ea874d43 Bluetooth: Add Atheros maryann PIDVID support

for application to the 3.0.y, 3.2.y, and 3.3.y stable trees.  These
add additional USB IDs to the list recognized by the ath3k firmware
loader.

Henry-Nicolas Tourneur wrote[1]:

> I did just complete a test using a 3.0.25 and it's working with the
> patched kernel.
> rfkill switches are working and pairing is working too :)
>
> All done using Wheezy bluetooth stack with gnome tools.

so the second of the two patches is

 Tested-by: Henry-Nicolas Tourneur <henry.nicolas@tourneur.be>

Both patches have been in linux-next for a while.  The first reached
Linus's master a few weeks ago and the second hit master today.

Thanks,
Jonathan

[1] http://bugs.debian.org/664726
