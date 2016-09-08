Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix reason code used for rejecting SCO
 connections
To: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
References: <1473328811-25338-1-git-send-email-frederic.dalleau@collabora.co.uk>
From: Frederic Dalleau <frederic.dalleau@collabora.co.uk>
Message-ID: <1313e7d9-1cfe-bb7e-2037-fdbc57412214@collabora.co.uk>
Date: Thu, 8 Sep 2016 12:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <1473328811-25338-1-git-send-email-frederic.dalleau@collabora.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08/09/2016 12:00, Frédéric Dalleau wrote:
> A comment in the code states that SCO connection should be rejected
> with the proper error value between 0xd-0xf. The code uses
> HCI_ERROR_REMOTE_LOW_RESOURCES which is 0x14.

I borrowed the title from a previous patch was already doing that

http://permalink.gmane.org/gmane.linux.bluez.kernel/53456

BR,
Fred
