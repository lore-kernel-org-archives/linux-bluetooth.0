Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Jun 2014 15:21:01 +0530
Message-ID: <CAFawTAx4Lpy2qkijcMTEHWqapJkKuZD0EmkLMuC-wurGP6N7hw@mail.gmail.com>
Subject: Query regarding gatt server support in bluez-5.16
From: Dibyendu Roy <diby.roy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I'm working on gatt server implementation on bluez-5.16.
It seems bluez-5.x has same client and server interface exposed for
applications.

I have few doubts regarding gatt server implementation.

How bluez will populate gatt primary services, characteristics and
characteristics descriptors?
I could only see RegisterService/UnregisterService in doc/gatt-api.txt.

Please let me know the API's/properties need to be called for gatt server.

Thanks in advance.


-- 
BR
Dibyendu
