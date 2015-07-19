Return-Path: <cyrus@holtmann.org>
Message-ID: <55AC27E5.5010509@gmail.com>
Date: Mon, 20 Jul 2015 00:42:45 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Szymon Janc <Szymon.Janc@tieto.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Peripheral role support for android
References: <558DE8B3.3060102@gmail.com> <650B748F-76F8-4031-9397-E65D18AD01A4@holtmann.org>
In-Reply-To: <650B748F-76F8-4031-9397-E65D18AD01A4@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

just a quick update from my side so that you know, I'm still active.

Done:
1) kernel backports: provide patches necessary to support the current 
linux-next master
2) android/bluetooth: implement bt_le_read_adv_features() to retrieve 
num supported instances from the kernel
3) android/bluetooth: change prepare_le_features() to retrieve the max 
number of adv instances from the kernel and save it to the adapter 
struct - will use bt_le_read_adv_features()
4) android/gatt: change [un]register_app() to correctly manage app ids 
(aka instance ids) in the permitted range including appropriate error 
handling when the max number of instances is reached
5) android/bluetooth: implement bt_le_{add|remove}_advertising() to 
support the new multi-adv features in the kernel
6) android/gatt: implement the handle*multi_adv*() methods using 
bt_le_{add|remove}_advertising()

Currently working on:
7) android/tester-{bluetooth|gatt}: write supporting tests

Florian
