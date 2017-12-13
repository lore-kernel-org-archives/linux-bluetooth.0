Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171212125832.13440-1-sbrown@cortland.com>
References: <20171212125832.13440-1-sbrown@cortland.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Dec 2017 10:27:57 -0200
Message-ID: <CABBYNZLt5ELEco4UnV8SZMLtPGpC9hRRkbHbpqrLqTEAPDns5A@mail.gmail.com>
Subject: Re: [PATCH V2 0/8] mesh: Add configuration commands to meshctl
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian, Inga,

On Tue, Dec 12, 2017 at 10:58 AM,  <sbrown@cortland.com> wrote:
> From: Steve Brown <sbrown@cortland.com>
>
> This work was done in conjunction with Zephyr pull request.
> https://github.com/zephyrproject-rtos/zephyr/pull/5322
>
> Steve Brown (8):
>   mesh: meshctl: Change command names to <cmd>-<get/set>
>   mesh: meshctl: Add add/get Subscribe
>   mesh: meshctl: Add set heartbeat command
>   mesh: meshctl: Add get app keys command
>   mesh: meshctl: Add get publish command
>   mesh: meshctl: Add set/get proxy command
>   mesh: meshctl: Add get/set identity
>   mesh: meshctl: Add get/set relay command
>
>  mesh/config-client.c | 452 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  mesh/net.c           |  20 ++-
>  2 files changed, 447 insertions(+), 25 deletions(-)
>
> --
> 2.11.0

Can you guys take a look at this? I intend to push them later today.


-- 
Luiz Augusto von Dentz
