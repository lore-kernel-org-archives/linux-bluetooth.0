Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 09:46:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: uuid_t and bt_uuid_t
Message-ID: <20120119074636.GA17170@x220.P-661HNU-F1>
References: <4F175FC1.3060403@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F175FC1.3060403@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Jan 18, 2012, Brian Gix wrote:
> Can anybody tell me why we have to almost-but-not-quite equivalent
> storage mechanisms for UUIDs in (user-space) BlueZ?  This is
> accompanied by multiple sets of utilities as well.  It looks like
> one is targeting SDP and one isn't.  However, I need to occasionally
> translate from one form to the other.
> 
> They both include a "type" which is a u8 in one instance, and an
> enum in the other.  And then they both include a union for the u16,
> u32 and u128.
> 
> Is one suppose to be in network order, and the other native?  I
> can't tell just from looking at the various usages.

The intention is to eventually move all code over to bt_uuid_t and get
rid of uuid_t. The problem with uuid_t is that it uses different byte
order depending on the UUID length. E.g. 16 and 32 are stored in host
byte order while 128 is stored in SDP byte order (big endian). The
purpose if bt_uuid_t it to have a type that's always in the host byte
order and thereby eliminate any confusion when using UUIDs with
protocols of different byte order requirements (e.g. SDP is big-endian
but ATT is little endian).

Johan
