Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 May 2010 05:10:37 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH v3] Bluetooth: Add blacklist support for incoming
 connections
Message-ID: <20100519081037.GE6219@vigoh>
References: <1274181632-29873-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274181632-29873-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-05-18 13:20:32 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> In some circumstances it could be desirable to reject incoming
> connections on the baseband level. This patch adds this feature through
> two new ioctl's: HCIBLOCKADDR and HCIUNBLOCKADDR. Both take a simple
> Bluetooth address as a parameter. BDADDR_ANY can be used with
> HCIUNBLOCKADDR to remove all devices from the blacklist.

Which circumstances?



-- 
Gustavo F. Padovan
http://padovan.org
