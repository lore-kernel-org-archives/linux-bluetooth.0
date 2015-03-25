Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPuY=zMC+MX=a-HisNnUSJ9zuORUtqukALj9hhv3EKHpTaGDEg@mail.gmail.com>
References: <CAPuY=zMC+MX=a-HisNnUSJ9zuORUtqukALj9hhv3EKHpTaGDEg@mail.gmail.com>
Date: Wed, 25 Mar 2015 16:21:38 +0200
Message-ID: <CAPuY=zODx6jR_QrtLmy5TqeDTavMBcm=Y7J6mQRZu4QKHgsE3Q@mail.gmail.com>
Subject: Fwd: bluez: using "service data" in BLE advertisement packets
From: Alon Ziv <nolaviz@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

We are developing some applications with non-connectable BLE
advertisers that broadcast data in a "service data" element of the
advertisement packet. So far we have used these devices with Android
and with iOS, both of which can easily support these devices as the
entire advertisement packet payload is exposed to scanning
applications.

Looking at the bluez DBus API, it appears that no equivalent
functionality exists: in particular, when the advertisement packets
are parsed (eir_parse() called from
src/adapter.c:update_found_devices()) any service-data elements are
simply discarded. Even worse (for us), if the devices' advertisements
are not marked "discoverable" they are simply dropped outright. And
even if the device is discoverable, it looks like we'd get only a
single notification when the device is first seen - but we won't be
able to verify it is still in range (i.e. continued reception of
advertisement packets).

Is the above summarization correct?

(The API documentation claims to support "observer" mode, but these
limitations actually put the lie to this statement - an observer is
supposed to see _all_ advertisement packets, including non-first ones
and those from non-discoverable devices...)

Regards
-- Alon Ziv
