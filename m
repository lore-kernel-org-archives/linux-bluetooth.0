Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 7 Jun 2012 11:08:30 +0530
Message-ID: <CA+_sZW_d7hZFvko1eaJJeDsV+QBohx12jgUoGwe=Uu9gCCpZEQ@mail.gmail.com>
Subject: [RFC] Behaviour when LTK is generated as a slave
From: vishal agarwal <vishal.bluez@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	vinicius.gomes@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

In file mgmtops.c in function mgmt_new_ltk, function bonding_complete
is called only if ev->key.master is true.
It means that as a slave when LTK is generated bonding_complete
function will not be called. Is it intended? If so please help me in
understanding this behaviour.

Thanks
Vishal
