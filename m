Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 15:11:47 +0800
Message-ID: <ac8af0be0902112311r2aa8f696ta847fc6647b4fbb4@mail.gmail.com>
Subject: [PATCH 0/4] HFP Gateway profile
From: Zhao Forrest <forrest.zhao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: event <event.riga@gmail.com>, forrest.zhao@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I picked up Leonid's patch for HFP Gateway profile and split it into
4 smaller pieces. The main changes are:
1 the coding style fix to align with BlueZ coding style
2 fixed the obvious bugs in hf_io_cb();

The patch set include the following 4 patches:
1 add the D-Bus interface definition for HFP Audio gateway
2 add the basic framework support for HFP Audio gateway
3 the main part for HFP Audio gateway
4  IPC integration part for HFP Audio gateway

Leonid,
Since you're the original author of this patch you may know the best
of "HFP Audio gateway" patch. Let's work together to respond to the
review comments and push to patch into BlueZ upsteam :)

Thanks,
Forrest
