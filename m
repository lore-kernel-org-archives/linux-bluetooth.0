Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 7 Jun 2011 11:41:03 -0300
Message-ID: <BANLkTinUNvtonVmErqwz-t=YufQha+k+HQ@mail.gmail.com>
Subject: Generic Attribute API race condition
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

There is a potential race condition in the Generic Attribute API. I'd
like to collect opinions to avoid re-work later.

How to reproduce:
- call CreateDevice() for a device which exports a GATT based service:
CreateDevice will discover all primary services
  and the Generic API will register the object paths for all found services
- Call DiscoverCharacteristics() of the primary service followed by
Characteristic GetProperties(), expected result: read all
characteristics properties outcome: partial characteristics properties
may appear.

This problem happens because DiscoverCharacteristics() doesn't wait
for all characteristic VALUES, it returns after discovering all
characteristic DECLARATIONS.
Wait for characteristic values is a problem, attributes may require
authentication or authorization.

Suggestions are:
1. Report discovered characteristic values using PropertyChanged:
Returning empty properties values (for GetProperties) if the discovery
is in progress

2. Block GetProperties() if there is a discovery pending: returning
after discovery finishes. Timeout can still happen!

3. Return Busy for GetProperties() if there is a characteristic
discovery in progress

Comments?

BR,
Claudio
