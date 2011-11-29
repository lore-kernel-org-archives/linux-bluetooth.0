Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Test Management interface for LE with latest kernel. 
Date: Tue, 29 Nov 2011 06:19:39 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4A01D9C3@banasiexm01.ASIA.ROOT.PRI>
References: <AcyCnA5DqBiEIGAzQEqnbRbpdBNd8AAAHtNw>
	<F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
 <F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4785205C@banasiexm01.ASIA.ROOT.PRI>
 <7769C83744F2C34A841232EF77AEA20C01DCC8DD1C@dnce01.ent.ti.com>
 <F82830D409D80E4881C83250E051B74B478523E8@banasiexm01.ASIA.ROOT.PRI>
 <F0070FBC0FB3174D8D11444EB2D5B0260106E6@DNCE02.ent.ti.com>
 <F82830D409D80E4881C83250E051B74B478528C2@banasiexm01.ASIA.ROOT.PRI>
In-Reply-To: <F82830D409D80E4881C83250E051B74B478528C2@banasiexm01.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
We were trying to test the BT LE scan/connect, using the MGMT_INTERFACE. I have enabled the enable_le && enable_mgmt in kernel. But I am seeing the below error. Could you please help me with the same? 

Error: " Too small mgmt_device_found event packet. "

Latest code:
Bluez: http://git.kernel.org/?p=bluetooth/bluez.git;a=summary 
Kernel: http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next.git;a=summary 

Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
