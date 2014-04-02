Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140402111346.GA3770@t440s.lan>
References: <CAHZ1yCkNddT6MxBkRz0dNdXGn+MWZECK1L6XTaouRLLkECH5eg@mail.gmail.com>
	<CAHZ1yCmTzSOHDQ20szZucMrmYLvKRMpWkaLXBtvJ519EU8pBWg@mail.gmail.com>
	<20140402052134.GA27831@t440s.P-661HNU-F1>
	<20140402111346.GA3770@t440s.lan>
Date: Wed, 2 Apr 2014 16:54:35 -0700
Message-ID: <CAHZ1yCmj2GLQQQfU+MnknhTZOZf218zRN1JBhrrYj_WC9C_+EA@mail.gmail.com>
Subject: Re: BUG: l2cap and rfcomm bind with 0 psm or channel no longer allocate
From: Scott James Remnant <keybuk@google.com>
To: Scott James Remnant <keybuk@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 2, 2014 at 4:13 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> FWIW, for the user space side this should now be fixed. It could use a
> bit more testing though, however at least with our test-profile script
> the RFCOMM channel auto-allocation and resulting SDP record seems to be
> fine.
>

Patch looks the same (just less hacky) as I tried here - will test it
out tomorrow!

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
