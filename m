Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Scheduled to kill the session whenever
 VIRTUAL_CABLE_UNPLUG is received by IUT
From: Marcel Holtmann <marcel@holtmann.org>
To: Vikram Kandukuri <vkandukuri@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090701060948.GA7505@atheros-laptop>
References: <20090701060948.GA7505@atheros-laptop>
Content-Type: text/plain
Date: Tue, 30 Jun 2009 06:58:34 -0700
Message-Id: <1246370314.12994.141.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

> Subject: [PATCH] Bluetooth: Scheduled to kill the session whenever VIRTUAL_CABLE_UNPLUG is received by IUT
> 
> There is a test case in PTS tool; PTS will send the VIRTUAL_CABLE_UNPLUG
> command to IUT. IUT should disconnect the channel and kill the session
> when it receives VIRTUAL_CABLE_UNPLUG command. VIRTUAL_CABLE_UNPLUG
> is parsed by hidp.ko but it is not scheduled to do so (There is no
> schedule code). So I have added hidp_schedule to kill the session.

patch has been added to all three trees. Thanks.

Regards

Marcel


