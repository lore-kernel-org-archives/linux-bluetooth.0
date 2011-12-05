Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: SMP Key distribution
Date: Mon, 5 Dec 2011 09:02:00 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02643FFBB@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

According to the SMP spec (Vol3, Part H, Appendix 5.3.4), keys are distributed in a specific order, where the slave first sends its LTK,EDIV, RAND , IRK, ADDR TYPE and signature key (according to the key distribution parameter. Only when the slave completes its key distribution, the master then starts distributing its own keys (same order, according to the master key distribution options). In the current implementation in the smp.c, it seems that we start distributing our keys too early (after the MASTER IDENTIFICATION message, ignoring the possibility of Addr type and signature keys which may come from the slave. This may break the key distribution phase.

Has anyone seen this or has anything to comment on that ?

Thanks,

Chen Ganir 
