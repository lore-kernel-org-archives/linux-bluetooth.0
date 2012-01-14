Return-Path: <cyrus@holtmann.org>
Message-ID: <1326559307.6454.270.camel@aeonflux>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with
 bytes
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <keybuk@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 14 Jan 2012 17:41:47 +0100
In-Reply-To: <1326505957-27555-3-git-send-email-keybuk@chromium.org>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	 <1326505957-27555-3-git-send-email-keybuk@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> Since the specification allows the PIN to be a sequence of arbitrary
> octets, and not a UTF-8 string, allow the userspace agent to reply
> with such a sequence (as a D-Bus Array of Bytes).
> 
> This means a userspace agent can deal with devices that require their
> BD_ADDR (or the host's) as a PIN, and take care of trying multiple of
> such requirements.

this has been discussed before and the answer is a clear no to this.

You can however write a plugin that can handle binary PIN codes.

Regards

Marcel


