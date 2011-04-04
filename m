Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=ce+qfeS14zX-k0qrt75iGP1d7ig@mail.gmail.com>
References: <BANLkTi=ce+qfeS14zX-k0qrt75iGP1d7ig@mail.gmail.com>
Date: Mon, 4 Apr 2011 12:08:26 +0300
Message-ID: <BANLkTinBOp+g44eCe6_s_w0nZBnPHpk8AQ@mail.gmail.com>
Subject: Re: [PATCH] Fix check for valid SCO socket before shutdown
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 1, 2011 at 5:20 PM, Daniel Örstadius
<daniel.orstadius@gmail.com> wrote:
>
>

Ack, this is actually a regression create by commit
d3f69537a46b1050d2415ca4afcdedba967096e8

-- 
Luiz Augusto von Dentz
Computer Engineer
