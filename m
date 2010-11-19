Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290178241-8358-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1290178241-8358-1-git-send-email-anderson.lizardo@openbossa.org>
	<1290178241-8358-2-git-send-email-anderson.lizardo@openbossa.org>
Date: Fri, 19 Nov 2010 10:53:21 -0400
Message-ID: <AANLkTin8J=9NizoyKXPdeYt+Z-Su=gwKMvLCwiC0OYqi@mail.gmail.com>
Subject: Re: [PATCH 2/2] Avoid reallocations of services UUID array
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 19, 2010 at 10:50 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> The array of service UUIDs used by the DeviceFound signal contains the
> same information from the GSList of services. Instead of reallocating
> this array on each signal, store it on the remote_dev_info structure and
> only reallocate it if there are new UUIDs.

Oops, just noticed I forgot to free the dev->uuids array. Will send a
fixed patch ASAP.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
