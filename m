Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDCE598.20808@codeaurora.org>
Date: Mon, 05 Dec 2011 07:39:04 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "Ganir, Chen" <chen.ganir@ti.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SMP Key distribution
References: <F0070FBC0FB3174D8D11444EB2D5B02643FFBB@DNCE02.ent.ti.com>
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02643FFBB@DNCE02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On 12/5/2011 1:02 AM, Ganir, Chen wrote:
> Hi.
>
> According to the SMP spec (Vol3, Part H, Appendix 5.3.4), keys are distributed in a specific order, where the slave first sends its LTK,EDIV, RAND , IRK, ADDR TYPE and signature key (according to the key distribution parameter. Only when the slave completes its key distribution, the master then starts distributing its own keys (same order, according to the master key distribution options). In the current implementation in the smp.c, it seems that we start distributing our keys too early (after the MASTER IDENTIFICATION message, ignoring the possibility of Addr type and signature keys which may come from the slave. This may break the key distribution phase.
>
> Has anyone seen this or has anything to comment on that ?
>

Currently the SMP code is hard coded to only support a single key, which 
is the LTK+MID from the Slave to the Master.

You are correct that we will need to ensure that all of the keys are 
handled correctly, including ensuring proper order, once we add support 
for additional key distribution.  At the moment though, that is a moot 
question.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
