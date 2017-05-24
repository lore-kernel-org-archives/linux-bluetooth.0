Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Josh Van Tol <josh@afdengineering.com>
Date: Wed, 24 May 2017 17:28:11 -0500
Message-ID: <CABdDuZ0vRS=xkvaXTr7Fax_MxR5hxX4j-mok-ck7c-ZdSv9Vug@mail.gmail.com>
Subject: Questions about GATT server example in /test/example-gatt-server.py -
 Generice access service can't be overidden
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to build a custom device using BlueZ, and have been using
the examples and tests that are included with BlueZ as a starting
point.

The problem I'm running into is that I'd like to provide my own
implementation of the Generic Access Service (UUID '1800') but I get
the error:
Failed to register application: org.bluez.Error.Failed: Failed to
create entry in database

I would presume that this is because there's already such a service
registered. Can anyone give me a pointer as to the proper way to
un-register the existing service (or prevent it from being installed)?

Regards,
Josh van Tol
