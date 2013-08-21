Return-Path: <cyrus@holtmann.org>
Message-ID: <5214C9DD.3090000@globaledgesoft.com>
Date: Wed, 21 Aug 2013 19:38:29 +0530
From: Sathish Narasimman <sathish.n@globaledgesoft.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE GATT service discovery Over BR/EDR
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am reading core spec 4.0.
GATT Features regarding Primary Service Discovery in page: 1911

"GATT service discovery over BR/EDR transport will list services that 
only run
over an LE transport and therefore only SDP service discovery shall be used
on BR/EDR."

Though SDP Service Discovery is able to get all the related service 
information. What is the use of
GATT Service Discovery which gives only LE Information on BR/EDR Controller.

Thanks,
Sathish N



