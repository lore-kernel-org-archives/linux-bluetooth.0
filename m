Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512344374.16639.18.camel@ewol.com>
Subject: meshctl: Can't connect via Node Identity advertisement
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 03 Dec 2017 16:39:34 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connect via Net ID works without a problem.

I'm using meshctl with zephyr's mesh_shell (upstream version)

I provision the shell and turn on it's gatt-proxy. Then I exit meshctl,
run it again and issue a "connect 0". It reconnects to the mesh without
 a problem.

If I turn off the shell's gatt-proxy, start meshctl, issue a 
"connect 0" and then issue a shell "ident". I get no connection. The
ident command only transmits advertisements for a short period of time.

The CONN_TYPE_IDENTITY path in parse_mesh_service_data() seems broken.
The comparison of data[0] and connection.type fails. The value of
data[0] is 1 (CONN_TYPE_IDENTITY) and the value of connection.type is
0.

Below is sniffer output of the two advertisements.

Steve


Net ID Advertisement
systime=1512335672 freq=2402 addr=8e89bed6 delta_t=1000.969 ms rssi=-20
40 1a d0 59 81 b8 f1 cf 02 01 06 03 03 28 18 0c 16 28 18 00 d4 76 79 43 3f db 10 4a bf 47 10
Advertising / AA 8e89bed6 (valid)/ 26 bytes
    Channel Index: 37
    Type:  ADV_IND
    AdvA:  cf:f1:b8:81:59:d0 (random)
    AdvData: 02 01 06 03 03 28 18 0c 16 28 18 00 d4 76 79 43 3f db 10 4a
        Type 01 (Flags)
           00000110
               LE General Discoverable Mode
               BR/EDR Not Supported

        Type 03 (16-bit Service UUIDs)
           1828
        Type 16 (Service Data)
           UUID: 1828, Additional: 00 d4 76 79 43 3f db 10 4a

    Data:  d0 59 81 b8 f1 cf 02 01 06 03 03 28 18 0c 16 28 18 00 d4 76 79 43 3f db 10 4a
    CRC:   bf 47 10



Node Identity Advertisement
systime=1512335702 freq=2402 addr=8e89bed6 delta_t=30492.935 ms rssi=-19
40 22 d0 59 81 b8 f1 cf 02 01 06 03 03 28 18 14 16 28 18 01 cb 3b d5 82 b5 1f 32 00 c6 36 a1 be 9b 88 c5 b6 fd e1 b3
Advertising / AA 8e89bed6 (valid)/ 34 bytes
    Channel Index: 37
    Type:  ADV_IND
    AdvA:  cf:f1:b8:81:59:d0 (random)
    AdvData: 02 01 06 03 03 28 18 14 16 28 18 01 cb 3b d5 82 b5 1f 32 00 c6 36 a1 be 9b 88 c5 b6
        Type 01 (Flags)
           00000110
               LE General Discoverable Mode
               BR/EDR Not Supported

        Type 03 (16-bit Service UUIDs) 
           1828
        Type 16 (Service Data)
           UUID: 1828, Additional: 01 cb 3b d5 82 b5 1f 32 00 c6 36 a1 be 9b 88 c5 b6

    Data:  d0 59 81 b8 f1 cf 02 01 06 03 03 28 18 14 16 28 18 01 cb 3b d5 82 b5 1f 32 00 c6 36 a1 be 9b 88 c5 b6
    CRC:   fd e1 b3



