Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1242210030.8227.29.camel@optenet-laptop-unai>
References: <1242210030.8227.29.camel@optenet-laptop-unai>
Date: Sat, 16 May 2009 13:34:04 -0300
Message-ID: <2d5a2c100905160934o7141dd22s4bac3ace6588050d@mail.gmail.com>
Subject: Re: [PATCH] Allow to handle SDP records bigger than 512 bytes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Unai Uribarri <unaiur@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Unai,

On Wed, May 13, 2009 at 7:20 AM, Unai Uribarri <unaiur@gmail.com> wrote:
> sdp_append_to_pdu statically allocates a buffer of 512 bytes. This patch calculates
> the amount of memory needed and allocates dynamically using malloc.
>
>

Could you please test the following patch with the devices that was
triggering the crash:

http://gitorious.org/~vudentz/bluez/vudentzs-clone/commit/d3939bfff2f1c32f36b295d2c5173b11af686833

It is a very similar solution, though there are a lot of more places
addressed by it.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
