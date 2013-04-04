Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 18:44:44 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v4 0/2] Input1 Connectability revisited
Message-ID: <20130404214444.GA7065@echo>
References: <1365111113-13741-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365111113-13741-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On 14:31 Thu 04 Apr, Alex Deymo wrote:
> New version of this patch using Vinicius idea of ReconnectMode, except that
> instead of "passive" and "active" we use "Host" and "Device", since the
> the passive/active is relative to what end are you talking about (host/device)
> Names are free to change.

Sounds good to me. Just please change to lower case names to maintain
consistency with the rest of the API, see media-api.txt, for example.

> 
> Also, this patch set removes the input config file introduced in a previous
> version of this patch. This property is readonly after all, and is derived
> from the SDP record passed to the Input plugin init (input_device_register).
> This SDP record comes from the SDP cache and hid_device_probe ensures it is
> not NULL.
> 
> Comments are welcomed!
> 
> Alex Deymo (2):
>   input: Documentation for new Input1 interface
>   input: Implement the new ReconnectMode Input1 property.
> 
>  doc/input-api.txt       | 32 ++++++++++++++++++
>  profiles/input/device.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 118 insertions(+), 3 deletions(-)
>  create mode 100644 doc/input-api.txt
> 
> -- 
> 1.8.1.3
> 

Cheers,
-- 
Vinicius
