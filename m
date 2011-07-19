Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110615210400.GA8352@dell.ger.corp.intel.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	<1307554688-21555-1-git-send-email-hadess@hadess.net>
	<20110614080730.GC28890@dell.ger.corp.intel.com>
	<1308043116.26522.1.camel@air.hadess.net>
	<20110614094338.GA18317@dell.ger.corp.intel.com>
	<1308133135.9190.11.camel@air.hadess.net>
	<20110615210400.GA8352@dell.ger.corp.intel.com>
Date: Tue, 19 Jul 2011 14:26:07 +0300
Message-ID: <CABBYNZ+RmdxgAbDSyjHeQj3nYmAMBPCt6jZxNrpbR2o6GOUi4A@mail.gmail.com>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

Apparently there is something wrong when removing last adapter
bluetoothd start burning cpu, disabling adaptername fix the problem so
there might be something wrong in adapter remove callback, can you
take a look? Btw, Im using rawhide so I suppose adaptername should
work, right?

-- 
Luiz Augusto von Dentz
