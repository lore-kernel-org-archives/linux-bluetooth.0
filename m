Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120920114323.GA11861@x220>
References: <1347370387-17670-1-git-send-email-jprvita@openbossa.org>
 <1347370387-17670-3-git-send-email-jprvita@openbossa.org> <20120920114323.GA11861@x220>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Tue, 25 Sep 2012 14:37:59 -0300
Message-ID: <CAAngNMYj6M3hpc=4E3bfa6ajDyTyW2_OrMvWRSErd=G9yxGm6A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 03/11] core: Mutually exclude concurrent connections
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 20, 2012 at 8:43 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

(...)

>
> As a general note (not relating specifically to this patch) I'd like to
> see a clearer split and naming of LE/GATT-specific functionality and
> variables (function names, struct btd_adapter/device member naming &
> grouping, etc.). Right now these seem to be sprinkled all over the place
> which can be confusing for someone looking at the code from a
> BR/EDR-only or LE-only perspective.
>

Any suggestions on how to improve that? I've tried to improve naming
for quite a while before sending these for the first time to the list,
and neither I nor anyone else from INdT could come up with better
naming.

I'm sending an updated version now, than you can comment about other
improvements on top of that.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
