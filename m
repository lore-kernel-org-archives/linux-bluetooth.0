Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8b5debfa0903170313n64fc1955l7afb2c3511981619@mail.gmail.com>
References: <8b5debfa0903170313n64fc1955l7afb2c3511981619@mail.gmail.com>
Date: Tue, 17 Mar 2009 10:22:54 -0300
Message-ID: <2d5a2c100903170622m666752e7s5b05d6b96b193952@mail.gmail.com>
Subject: Re: [PATCH] Adding version check for plugins.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: alok barsode <alokbarsode@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

2009/3/17 alok barsode <alokbarsode@gmail.com>:
> Hi Marcel,
>
> As per the discussion on IRC, I am attaching a version check patch for plugins.
>
> Let me know if anything needs modifications.
>
> Cheers,
> Alok.
>

There are some trailing spaces around if (g_str_equal(desc->version,
VERSION) == FALSE), could you please fix them.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
