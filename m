Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 12:46:07 -0700
From: Greg KH <gregkh@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	"Cho, Yu-Chen" <acho@novell.com>,
	Henry-Nicolas Tourneur <henry.nicolas@tourneur.be>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Oliver Neukum <oliver@neukum.name>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] Add Atheros maryann PIDVID
 support
Message-ID: <20120419194607.GA31130@kroah.com>
References: <00c20c839b7ac6f027ab935f8cf0992c93c5f2fd.1329809368.git.acho@suse.com>
 <20120412215819.GA15416@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120412215819.GA15416@burratino>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 12, 2012 at 04:58:20PM -0500, Jonathan Nieder wrote:
> Hi Greg,
> 
> Please consider
> 
>  9498ba7a1d38 Bluetooth: Adding USB device 13d3:3375 as an Atheros AR3012
>  07c0ea874d43 Bluetooth: Add Atheros maryann PIDVID support
> 
> for application to the 3.0.y, 3.2.y, and 3.3.y stable trees.  These
> add additional USB IDs to the list recognized by the ath3k firmware
> loader.

Now applied, thanks.

greg k-h
