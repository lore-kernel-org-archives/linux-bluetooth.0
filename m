Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 26 Oct 2009 20:04:08 -0200
Message-ID: <f9d4bd30910261504l577041d7y72f7a68b9a9753e9@mail.gmail.com>
Subject: [PATCH] Local out of band properties
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is the first step to support secure simple pairing using out of
band mechanism(NFC, USB, ..).

First it is necessary export to applications a method to retrieve the data
that will be exchanged using out of band mechanism. "Hash" and "Randomizer"
properties were added in GetProperties method and PropertyChanged signal.

git://git.infradead.org/users/cktakahasi/bluez.git oob-local

Comments? Useless for now?



The second part of oob is set the exchanged oob data in the device struct
and reply the oob data when the host controller sends "Remote OOB Data
Request Event".

Initial proposal is here:
git://git.infradead.org/users/cktakahasi/bluez.git  oob-remote
It works, but we need to discuss the API.

Regards,
krau
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
