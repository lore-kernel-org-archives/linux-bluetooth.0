Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310985570.21109.157.camel@aeonflux>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
	<1310985570.21109.157.camel@aeonflux>
Date: Mon, 18 Jul 2011 13:54:40 +0300
Message-ID: <CABBYNZKdHjOcKuvhVF_BNcNxf3oJT19CQjVYx8Kb17CbT5M-2w@mail.gmail.com>
Subject: Re: [PATCH obexd 1/6] Make use of g_slist_free_full when elements are dynamically-allocated
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jul 18, 2011 at 1:39 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luis,
>
>> This avoid having to iterate twice in the list to free its elements.
>
> please make sure we have the same workaround for older GLib versions
> without this function. At this point of time, I wanna allow building it
> with older GLib versions. We can revisit that at some point in the
> future and remove that cruft, but for now it seems reasonable.

Right, Ive forgot about that.. gonna add in v2


-- 
Luiz Augusto von Dentz
