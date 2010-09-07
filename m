Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim7WPm4nyKVwU36ASMDTF_5N=eB8AnfutcODMv9@mail.gmail.com>
References: <AANLkTim7WPm4nyKVwU36ASMDTF_5N=eB8AnfutcODMv9@mail.gmail.com>
Date: Tue, 7 Sep 2010 23:36:32 +0530
Message-ID: <AANLkTikfGdrt2gL0gVnjA6gPYw1i+PXpbyWw0kFEf6gz@mail.gmail.com>
Subject: Why is l2cap_connect re-implemented in gattool instead of using btio wrappers?
From: Arun Kumar <arunkat@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

 Just trying to understand the need for a separate l2cap_connect
 re-implemention in gatttool.c instead of using bt_io_connect( ) wrapper
 from
 btio.c? Since current GATT implementation tries to work on existing BR/EDR,
 cant btio wrapper suffice for this initial step...

Best regards,
Arun
