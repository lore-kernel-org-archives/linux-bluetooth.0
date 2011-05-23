Return-Path: <cyrus@holtmann.org>
Message-ID: <4DDA5E2F.6070701@ethicstech.in>
Date: Mon, 23 May 2011 18:46:31 +0530
From: Siva kumar <sivakumar@ethicstech.in>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Is the BlueZ health device interface, problems with link security
 level is rectified
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

       Is the BlueZ health device interface, problems with link security 
level is rectified after applying the patch in HDP.C. i am trying to 
pair health device in bluez with ssp pairing , i am not able to get 
data. Only by disabling ssp mode i can get data with "hciconfig hci0 
sspmode 0". Is there any bug in Health Device Profile of bluez


