Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1247498933-30609-2-git-send-email-jprvita@gmail.com>
References: <1247498933-30609-1-git-send-email-jprvita@gmail.com>
	 <1247498933-30609-2-git-send-email-jprvita@gmail.com>
Date: Mon, 13 Jul 2009 13:38:16 -0300
Message-ID: <2d5a2c100907130938m7b7316f2g1f1112a8c14ba6be@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adapt A2DP functions to support the Sink role.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2009/7/13 João Paulo Rechi Vita <jprvita@gmail.com>:
> Modify a2dp_source_* functions to more generic a2dp_record(), a2dp_get(),
> a2dp_config(), a2dp_resume(), a2dp_suspend(), and a2dp_cancel() which can handle
> both the Sink and Source roles.

Ive pushed a simplified version of this patch to my tree, here:

http://gitorious.org/~vudentz/bluez/vudentzs-clone/commit/27c976732dea3d2599c005715369651df76eac83

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
