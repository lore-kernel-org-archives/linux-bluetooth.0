Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345653354-23720-2-git-send-email-s.syam@samsung.com>
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
	<1345653354-23720-2-git-send-email-s.syam@samsung.com>
Date: Thu, 23 Aug 2012 01:27:57 +0300
Message-ID: <CABBYNZLr1iENopeSbqqiQuryC0T99KkG=Go-K0j9zNca_ijpVQ@mail.gmail.com>
Subject: Re: [PATCH obexd v1 2/4] build: Require GLib 2.32 or later
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Wed, Aug 22, 2012 at 7:35 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> If we use GLib version less than 2.32 (more precisely < 2.31.2) then
> the following build error may occure in a 32 bit.

We had the issue with BlueZ but we did not bump the glib version,
which makes me wonder if you are able to compile bluetoothd?

-- 
Luiz Augusto von Dentz
