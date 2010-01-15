Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jan 2010 08:57:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Zotov <whitequark@whitequark.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Handset voice dial signalling patch
Message-ID: <20100115065717.GA15910@jh-x301>
References: <4B4D780F.1080405@whitequark.ru>
 <20100113083247.GA18980@jh-x301>
 <4B4D8C5A.8070006@whitequark.ru>
 <20100113092620.GA20024@jh-x301>
 <4B4E3A98.8000605@whitequark.ru>
 <20100114144123.GA31691@jh-x301>
 <4B4F8C1E.209@whitequark.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B4F8C1E.209@whitequark.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Jan 15, 2010, Peter Zotov wrote:
> I fixed everything and created a patch with git format-patch.
> Probably the resulting file is intended to send as a email directly,
> but I don't know how to do this with Thunderbird, so it is attached.

An attachment is fine, thanks. The patch is now pushed upstream with one
more minor modification: I changed "start_dialing" to "enable" in
headset.c to be consistent with what it's called in the drivers.

Johan
