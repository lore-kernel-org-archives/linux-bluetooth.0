Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 12 Apr 2012 19:01:16 +0200
From: aep <aep@exys.org>
To: <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: Lenovo W510 Bluetooth Controller stopped working in 3.4-rc1
Message-ID: <abfb31f0565ebacddd25efec883e31dc@exys.org>
List-ID: <linux-bluetooth.vger.kernel.org>

not sure how to debug further. hci0 simply vanished without any trace 
left in dmesg.
lsusb says :
     Bus 001 Device 004: ID 0a5c:217f Broadcom Corp. Bluetooth 
Controller
git bisect says this one is the evil one:
     d7b7e79688c07b445bc52adfedf9a176be156f4b Bluetooth: Set supported 
settings based on enabled HS and/or LE
although i'm not sure if that is true, so here's the complete bisect 
log:

git bisect start '--' 'net/bluetooth'
git bisect bad dd775ae2549217d3ae09363e3edb305d0fa19928
git bisect good b01543dfe67bb1d191998e90d20534dc354de059
git bisect good 2f39cdb7a270da24532734dfdfd10c490be981c4
git bisect bad 7770c4aacaf34fb69cb2acfb7469e9b4e34f1674
git bisect bad 1b009c982482ee0e4cbabcd9bdae690a29119ede
git bisect bad cacaf52f51697f832a26e8fdaa7b8e85785085da
git bisect good 801f13bd8ecc58f2cf42ec602a2b5db10fc5a132
git bisect bad d930650b59be72342bc373ef52006ca99c1dd09e
git bisect bad 4b95a24ce12c4545fd7d2e3075841dc3119d1d71


i guess what i should try is to add any of these parameters when 
loading the module,
but that doesn't seem to work:

[  179.793014] btusb: Unknown parameter `enable_hs'

grep enable_hs ./drivers/bluetooth/btusb.ko  confirms there is no such 
string.


thanks
