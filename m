Return-Path: <cyrus@holtmann.org>
Message-ID: <1261185699.4b2c2aa37a9c4@www.fastmail.com.br>
Date: Fri, 18 Dec 2009 23:21:39 -0200
From: dcobra@videam.com.br
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>  <4B2A4B90.1040009@videam.com.br>  <4B2BBF58.4030901@videam.com.br>  <1261173899.4041.96.camel@localhost.localdomain>  <1261176544.4b2c06e0e0eae@www.fastmail.com.br> <1261177111.4041.99.camel@localhost.localdomain>
In-Reply-To: <1261177111.4041.99.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel:

> even if I use Bluetooth on a daily basis, I don't use any mouse or
> keyboard devices anymore. So I have no idea on how many people are
> actually using these.

I'm getting the impression they are not very popular! To me it seemed like a
clear advantage to use a mouse with my notebook's built-in bluetooth module
without needing a dongle.

> I used to travel with a lot of HID devices to just
> be able to test and verify things, but I don't do that anymore. So I
> wouldn't be of much help until I am back at home and have my device
> library at my disposal (and bought new batteries).

O.k., if you find the time to look into this, I installed hcidump (didn't know
about it until you mentioned it), and here's the output with the "-t" flag (any
others I should use?) during a mouse reconnection:


HCI sniffer - Bluetooth packet analyzer ver 1.42                       
device: hci0 snap_len: 1028 filter: 0xffffffff                         
1261183973.054875 > HCI Event: Connect Request (0x04) plen 10          
1261183973.054911 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
1261183973.062868 > HCI Event: Command Status (0x0f) plen 4                    
1261183973.255871 > HCI Event: Role Change (0x12) plen 8                       
1261183973.349870 > HCI Event: Connect Complete (0x03) plen 11                 
1261183973.349892 < HCI Command: Read Remote Supported Features (0x01|0x001b)
plen 2                                                                         
  
1261183973.351861 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7  

1261183973.351870 > ACL data: handle 42 flags 0x02 dlen 12                     

    L2CAP(s): Connect req: psm 17 scid 0x0060                                  

1261183973.351932 < ACL data: handle 42 flags 0x02 dlen 16                     

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0060 result 1 status 0           

      Connection pending - No futher information available                     

1261183973.351937 < ACL data: handle 42 flags 0x02 dlen 10                     

    L2CAP(s): Info req: type 2                                                 

1261183973.358863 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183973.361860 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183973.363865 > HCI Event: Command Status (0x0f) plen 4                    

1261183973.363881 < HCI Command: Remote Name Request (0x01|0x0019) plen 10     

1261183973.373864 > HCI Event: Read Remote Supported Features (0x0b) plen 11   

1261183973.375857 > HCI Event: Command Status (0x0f) plen 4                    

1261183973.443867 > HCI Event: Remote Name Req Complete (0x07) plen 255        

1261183977.351019 < ACL data: handle 42 flags 0x02 dlen 16                     

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0060 result 0 status 0           

      Connection successful                                                    

1261183977.361870 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.383875 > ACL data: handle 42 flags 0x02 dlen 16                     

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4                        

      MTU 133                                                                  

1261183977.383896 < ACL data: handle 42 flags 0x02 dlen 18                     

    L2CAP(s): Config rsp: scid 0x0060 flags 0x00 result 0 clen 4               

      MTU 133                                                                  

1261183977.383901 < ACL data: handle 42 flags 0x02 dlen 12                     

    L2CAP(s): Config req: dcid 0x0060 flags 0x00 clen 0                        

1261183977.391870 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.393868 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.403870 > ACL data: handle 42 flags 0x02 dlen 17                     

1261183977.405872 > ACL data: handle 42 flags 0x01 dlen 1                      

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4               

      MTU 133                                                                  

1261183977.407872 > ACL data: handle 42 flags 0x02 dlen 12                     

    L2CAP(s): Connect req: psm 19 scid 0x0061                                  

1261183977.407895 < ACL data: handle 42 flags 0x02 dlen 16                     

    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0061 result 1 status 2           

      Connection pending - Authorization pending                               

1261183977.408042 < ACL data: handle 42 flags 0x02 dlen 16                     

    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0061 result 0 status 0           

      Connection successful                                                    

1261183977.413868 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.415868 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.437867 > ACL data: handle 42 flags 0x02 dlen 16                     

    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4                        

      MTU 133                                                                  

1261183977.437892 < ACL data: handle 42 flags 0x02 dlen 18                     

    L2CAP(s): Config rsp: scid 0x0061 flags 0x00 result 0 clen 4               

      MTU 133                                                                  

1261183977.437898 < ACL data: handle 42 flags 0x02 dlen 12                     

    L2CAP(s): Config req: dcid 0x0061 flags 0x00 clen 0                        

1261183977.443870 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.445866 > HCI Event: Number of Completed Packets (0x13) plen 5       

1261183977.459875 > ACL data: handle 42 flags 0x02 dlen 18                     

    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4               

      MTU 133                                                                  

1261183977.461865 > ACL data: handle 42 flags 0x02 dlen 14                     

    L2CAP(d): cid 0x0041 len 10 [psm 19]                                       

      HIDP: Data: Input report                                                 

1261183977.464114 < ACL data: handle 42 flags 0x02 dlen 11                     

    L2CAP(d): cid 0x0061 len 7 [psm 19]                                        

      HIDP: Data: Output report                                                

1261183977.464180 < ACL data: handle 42 flags 0x02 dlen 7                      

    L2CAP(d): cid 0x0061 len 3 [psm 19]                                        

      HIDP: Data: Output report                                                

1261183977.464223 < ACL data: handle 42 flags 0x02 dlen 7                      

    L2CAP(d): cid 0x0061 len 3 [psm 19]                                        

      HIDP: Data: Output report                                                

1261183977.464294 < ACL data: handle 42 flags 0x02 dlen 14                     

    L2CAP(d): cid 0x0061 len 10 [psm 19]                                       

      HIDP: Data: Output report                                                

1261183977.464335 < ACL data: handle 42 flags 0x02 dlen 8                      

    L2CAP(d): cid 0x0061 len 4 [psm 19]
      HIDP: Data: Output report
1261183977.464375 < ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0061 len 7 [psm 19]
      HIDP: Data: Output report
1261183977.464416 < ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0061 len 3 [psm 19]
      HIDP: Data: Output report
1261183977.464455 < ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0061 len 10 [psm 19]
      HIDP: Data: Output report
1261183977.466860 > HCI Event: QoS Setup Complete (0x0d) plen 21
1261183977.471858 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183977.473858 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183977.476859 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183977.478862 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183977.480857 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183977.484866 > HCI Event: Mode Change (0x14) plen 6
1261183977.487865 > ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 19]
      HIDP: Data: Input report
1261183977.697866 > ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 19]
      HIDP: Data: Input report


This is all Greek to me. The whole process took 4.6 seconds (a little less than
the 5-6 seconds I had estimated without actually clocking it, but still
significantly longer than under Windows XP, where the mouse connects in under
one second every time). Most of the delay takes place between the "Remote Name
Req Complete" and reception of the next ACL data. Does that tell you
something?

As far as logs go, during reconnection the only lines that were logged into
/var/log/messages were (any other log files I should check?):


Dec 18 22:52:57 photon kernel: input: Targus Bluetooth Media Mouse for Notebook
as
/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/bluetooth/hci0/hci0:42/input14
Dec 18 22:52:57 photon kernel: generic-bluetooth 0005:0461:4B01.0004:
input,hidraw0: BLUETOOTH HID v1.08 Mouse [Targus Bluetooth Media Mouse for
Notebook] on 00:18:F3:8C:F7:73

Regards,

Daniel
