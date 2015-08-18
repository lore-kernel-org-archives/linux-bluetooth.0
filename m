Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1438603053-4865-1-git-send-email-anchit.n@samsung.com>
References: <1438603053-4865-1-git-send-email-anchit.n@samsung.com>
Date: Tue, 18 Aug 2015 11:06:53 +0300
Message-ID: <CABBYNZ+of+pkV5Gm1M4T6TiHSvnAaer+O6s0K=HkzObYnQ+X7w@mail.gmail.com>
Subject: Re: [PATCH] tools/l2test: Fix memory leak
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	sachin.dev@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Mon, Aug 3, 2015 at 2:57 PM, Anchit Narang <anchit.n@samsung.com> wrote:
> The code to exit from program is changed.
> Rather than directly calling exit(), memory allocated to buf is released
> to gracefully exit.

These cases I considered false positives, calling exit should cause
the process to be terminated and any resource allocated to it will be
freed anyway.

-- 
Luiz Augusto von Dentz
