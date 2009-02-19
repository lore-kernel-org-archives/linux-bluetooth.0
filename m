Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 19 Feb 2009 21:19:59 +0800
Message-ID: <ac8af0be0902190519v150905c9iea04a86835750c5c@mail.gmail.com>
Subject: [PATCH 0/4] HFP Gateway profile -- take 2
From: Zhao Forrest <forrest.zhao@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: event <event.riga@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Compared with last version the change is:
1 fix the bug that HFP AG can't initiate the service-level connection
with HFP HF unit.
2 rebase the patch set against the BlueZ master

The patch set include the following 4 patches:
1 add the D-Bus interface definition for HFP Audio gateway
2 add the basic framework support for HFP Audio gateway
3 the main part for HFP Audio gateway
4  IPC integration part for HFP Audio gateway

Thanks,
Forrest
