Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Subject: Not able to set Default PHY configuration
Date: Fri, 10 Aug 2018 20:22:15 +0530
Message-id: <1533912735-3878-1-git-send-email-anupam.r@samsung.com>
References: <CGME20180810145329epcas2p28873946a2150bb9949f8877119ba4d3a@epcas2p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello list,
 Regarding the Set PHY configuration management command, I have a following observation during my test with a BT 5.0 LE Only controller
I am encountering error on SET PHY (2MTX) MGMT command from btmgmt.

[hci1]# phy
Supported phys: [0x7e00] [1MTX 1MRX 2MTX 2MRX CODEDTX CODEDRX ]
Configurable phys: [0x7800] [2MTX 2MRX CODEDTX CODEDRX ]
Selected phys: [0x600] [1MTX 1MRX ]

@ MGMT Command: Get PHY Configuration (0x0044) plen 0    
@ MGMT Event: Command Complete (0x0001) plen 15  
      Get PHY Configuration (0x0044) plen 12
        Status: Success (0x00)
        Supported PHYs: 0x7e00
          LE 1M TX
          LE 1M RX
          LE 2M TX
          LE 2M RX
          LE CODED TX
          LE CODED RX
        Configurable PHYs: 0x7800
          LE 2M TX
          LE 2M RX
          LE CODED TX
          LE CODED RX
        Selected PHYs: 0x0600
          LE 1M TX
          LE 1M RX


[hci1]# phy 2MTX
Could not set PHY Configuration with status 0x0d (Invalid Parameters)

 MGMT Command: Set PHY Configuration (0x0045) plen 4 
        Selected PHYs: 0x0800
          LE 2M TX
@ MGMT Event: Command Status (0x0002) plen 3 
      Set PHY Configuration (0x0045)
        Status: Invalid Parameters (0x0d)


As per https://kernel.googlesource.com/pub/scm/linux/kernel/git/bluetooth/bluetooth-next/+/master/net/bluetooth/mgmt.c#3412

if ((selected_phys & unconfigure_phys) != unconfigure_phys)
	return mgmt_cmd_status(INVALID_PARAMS)

In my case, unconfigurable PHY is 0x600(1MTX and 1MRX) [supported_phys(0x7e00) &  ~configure_phys (0x7FF) = 0x600]
If from btmgmt, user wants to select 2MTX (0x800), then the above condition returns error to user, 
whereas I think, out intention here is to allow kernel to set preference of 2MTX to controller, as 2MTX is a configurable PHY? Am I missing something here?

Actually, I am not sure if unconfigure_phys logic is added to prevent user to select one of the unconfigureable PHY's.
If above is the case, then will not be the following logic correct?


   + if (selected_phys & unconfigure_phys)
   +		return ERROR
   + else
   +		proceed

which will basically mean if any of the bits in the user's selected bit field matches with that of the unconfigurable PHY's bits, then we may return error to user, otherwise proceed normally?
Please share your opinion. Thank you very much!

BR,
-Anupam Roy
