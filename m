Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F49C47A1-077C-41E2-A36B-3DE9EF1A9E19@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com>
	<B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
	<CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com>
	<F49C47A1-077C-41E2-A36B-3DE9EF1A9E19@holtmann.org>
Date: Tue, 1 Jul 2014 08:22:04 -0700
Message-ID: <CA+bD78j4RfvZdMoKLcfDdtsy1g_bgZ-vnbAOY80W_JcZDNuEyA@mail.gmail.com>
Subject: Re: [RFC] doc: Add EIR to device properties
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 1, 2014 at 3:42 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>>> This patch proposes an extension to the D-Bus Device API to allow
>>>> an application access to the last EIR data received from a device
>>>> in inquiry or advertising mode.
>>>>
>
> I think this looks pretty along the lines what I am looking for. However I was thinking in a bit more detail likes this:
>
>         <- Search method call
>         -> New Device object / Updated device object
>         -> New Device object / Updated device object
>         -> Search method return -> array of objects with properties
>
> So you can treat the search dead simple and just display the results. However that way you can not monitor progress. If you want to monitor progress while search is running, you need to monitor changes to the device objects.
>

Sounds reasonable, would make it very easy from an application point of view.

This would place the EIR/AD/SR data in the device objects as a property then?

Scott
-- 
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
