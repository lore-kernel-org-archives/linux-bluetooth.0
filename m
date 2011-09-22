Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RFC BlueZ 0/3] GATT: high level API for service registration
Date: Thu, 22 Sep 2011 16:56:35 -0400
Message-Id: <1316724998-1466-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This RFC series contain a proposal for a internal API that simplifies GATT
service registration on server implementations. It is built on top of current
"low level" attribute API, and both can be used at the same time without
problem.

As an example, I converted a service from the GATT example profile (see patch
#3).

I would like to hear your opinion on the approach (using varargs). There are
some limitations on current implementation:

* No support for aggregate format descriptors, included services
* Support for many descriptors is missing
* No support for "static" characteristic values. All readable or writeable
* characteristic needs a corresponding read or write callback

Comments are very welcome, even if it is to propose another API.

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
