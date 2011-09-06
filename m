Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK7HjoQC2gqeBbR7CSBC=w68ReFAVcnpAD8Nh0Yhm=O7g@mail.gmail.com>
References: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314805732-30418-3-git-send-email-frederic.dalleau@linux.intel.com>
	<CABBYNZK7HjoQC2gqeBbR7CSBC=w68ReFAVcnpAD8Nh0Yhm=O7g@mail.gmail.com>
Date: Tue, 6 Sep 2011 10:51:16 +0200
Message-ID: <CA+QXtDs+PJNYiCPwh=K7qoVVfZj3K5X6LNA6F9aZ1oWT8k0XLw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Fix asynchronously run request stream cb
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> +       g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, "Closed");
>
> We should probably create its own error domain instead of reusing
> BT_IO_ERROR, besides that it looks ok.

Should this domain be specific to gateway.c or more generic ?

Thanks,
Frédéric
