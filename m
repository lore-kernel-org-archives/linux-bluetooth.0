Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 May 2011 11:39:53 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez testing / connection closes
Message-ID: <20110524083953.GC2480@null>
References: <BANLkTimSf5fS66RxjjuTxeSY1MEJVYnTmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTimSf5fS66RxjjuTxeSY1MEJVYnTmQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Mon, May 23, 2011 at 10:18:08AM -0500, ext Mike wrote:
> I am trying to use a R&S bluetooth tester but bluez is disconnecting
> the device after ~5 seconds.  I thought I remembered someone a while
> back with the same problem on this mailing list, but I can't find it.
> Where do I start looking to change this behavior?  Is there a simple
> flag or is there a timer somewhere that I can turn off?
> 

Use hci RAW mode ioctl.

-- 
Ville
