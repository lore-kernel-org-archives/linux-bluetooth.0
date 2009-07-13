Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2009 00:02:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Adapt A2DP functions to support the Sink role.
Message-ID: <20090713210256.GA8480@jh-x301>
References: <1247498933-30609-1-git-send-email-jprvita@gmail.com> <1247498933-30609-2-git-send-email-jprvita@gmail.com> <2d5a2c100907130938m7b7316f2g1f1112a8c14ba6be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2d5a2c100907130938m7b7316f2g1f1112a8c14ba6be@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 13, 2009, Luiz Augusto von Dentz wrote:
> 2009/7/13 João Paulo Rechi Vita <jprvita@gmail.com>:
> > Modify a2dp_source_* functions to more generic a2dp_record(), a2dp_get(),
> > a2dp_config(), a2dp_resume(), a2dp_suspend(), and a2dp_cancel() which can handle
> > both the Sink and Source roles.
> 
> Ive pushed a simplified version of this patch to my tree, here:
> 
> http://gitorious.org/~vudentz/bluez/vudentzs-clone/commit/27c976732dea3d2599c005715369651df76eac83

The patches have been merged and pushed upstream. Thanks.

Johan
