Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 26 Jul 2012 11:03:47 +0300
Message-ID: <CABBYNZLMMkPkgj6EGCic63TptK8tioA_sMSkFH1zZS=p6bq3dA@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Optional acquire in Media API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jul 24, 2012 at 6:52 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> This patch series adds a flag to the Acquire method in the Media API, in order to fix the race condition described in patch v1 3/4.
>
> v1 tries to follow the proposal from Luiz by avoiding changes in the internal callbacks, and instead using the state information available in struct media_transport.
>
> Patch v1 4/4 needs careful review since the replacement of the in_use flag is not trivial.
>
> From original patch:
>
> This patch reopens the discussion started by the thread "when is acquire
> ok to call". The race condition seems to be real (even thought difficult
> to reproduce), and I couldn't think of any approach to solve this
> without altering the Media API.

Btw, I guess it is important to clarify that this doesn't break the
API as the new flag is ignored in previous versions. The other
important thing to mention is that this flag is not specific to one
role, otherwise we would have done this without adding a new API,
because there could be some situations where the transport must be
connected regardless of the role.

-- 
Luiz Augusto von Dentz
