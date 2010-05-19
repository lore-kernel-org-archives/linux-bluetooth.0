Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 May 2010 10:22:05 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add blacklist support for incoming
 connections
Message-ID: <20100519082205.GA18772@jh-x301>
References: <1274181632-29873-1-git-send-email-johan.hedberg@gmail.com>
 <20100519081037.GE6219@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100519081037.GE6219@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 19, 2010, Gustavo F. Padovan wrote:
> > In some circumstances it could be desirable to reject incoming
> > connections on the baseband level. This patch adds this feature through
> > two new ioctl's: HCIBLOCKADDR and HCIUNBLOCKADDR. Both take a simple
> > Bluetooth address as a parameter. BDADDR_ANY can be used with
> > HCIUNBLOCKADDR to remove all devices from the blacklist.
> 
> Which circumstances?

Whenever you have a badly behaving remote device that keeps on trying to
connect to you (e.g. an OPP spambot or someone trying to actively DoS
you). I gave some more details in my reply to Jaikumar a few days ago on
this mailing list.

Johan
