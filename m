Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: "yon ar c'hall" <yon.ar.chall@gmail.com>
Date: Mon, 23 Jan 2017 17:44:51 +0100
Message-ID: <CAOJvutMnJJJi=O1=e1kttqk4cLk_UvpwQyS4uetziqjsN_FX2g@mail.gmail.com>
Subject: Blood Pressure GATT LE profile
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

The Blood Pressure LE profile is not listed on the
www.bluez.org/profiles web page; can you please confirm whether this
information is up to date or not regarding Bluez 5.43 ?

Note : we downloaded the last Bluez source archive, and tried to
understand how the GATT LE profiles were implemented, e.g. for the
Health Thermometer profile, but we are missing some points of the
bluez's user-space architecture (are the "doc/*-api.txt" and the
"plugin/gatt-example.c" files still valid ? Is it just a matter of
D-BUS configuration/declaration as we can see in
"test/test-thermometer.py" ?). If it turns out that we have to
implement the Blood Pressure profile, could we get a pointer to some
programming information, please ?

Thanks.
-Yon
