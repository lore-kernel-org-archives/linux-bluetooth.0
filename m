Return-Path: <cyrus@holtmann.org>
Message-ID: <54F8584D.6020301@ubnt.com>
Date: Thu, 05 Mar 2015 15:21:17 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: DBus API for LTK OOB keys
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

     There is a MGMT "Load Long Term Keys Command" to feed keys to the 
Kernel which are stored in the BlueZ settings storage file and read 
during adapter init (load_devices->load_ltks). I searched through the 
code and couldn't find any means to feed LTK keys from "the outside", 
for example through DBus API. This is needed for an LE OOB pairing 
scheme, when key is known in advance by both parties and is not derived 
from pairing procedure. Is there a standardized way to add LTK keys 
"manually" or this is not supported-yet feature? According to setting 
storage rules "Direct access to the storage outside from bluetoothd is 
highly discouraged".

BR, Andrey
