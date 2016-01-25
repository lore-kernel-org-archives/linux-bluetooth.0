Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Date: Mon, 25 Jan 2016 12:53:52 -0500
Subject: Bluetooth Smart 5LoWPAN connection between two devices
Message-ID: <3916CF28FA2C014B862815C318D03FF5A0A7493AAF@Courier.syntech.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am unsure if this is the correct mailing list to post this question too.  If it is not, I apologize and would ask what is the appropriate list to ask this question (I have been unable to find anyother).

I am attempting to do a proof of concept where two devices will communicate using IPv6 over Bluetooth.  I have successfully established a connection with Bluetooth Legacy using BNEP but I am having trouble with Bluetooth Smart.

If the slave device is running Bluez 4 (4.101 on Ubuntu 14.04) and the master is running Bluez 5 (5.23 with Raspbian) the connection works using the following commands.  Not really sure if the connection is stable because it seems to have issues at times with some protocols.

Slave (Ubuntu 14.04 Bluez 4.101): 
      #need root access
      sudo su

      #enable 6lowpan over Bluetooth le
      echo 35 > /sys/kernel/debug/bluetooth/6lowpan_psm

       #start advertising Bluetooth LE service
      hciconfig hci0 leadv
master (Raspberry Pi Bluez 5.23):
       #need root access
       sudo su

       #enable 6lowpan over Bluetooth le
       echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable

       #establish le connection to master
       hcitool lecc 5C:F3:70:XX:XX:XX

       echo "connect 5C:F3:70:XX:XX:XX 1" > /sys/kernel/debug/bluetooth/6lowpan_control

I do not want to use Bluez 4.XX so I am attempting to get this to work with Bluez 5 on both the master and slave.  I have tried the following commands on both the Raspberry Pi with Bluez 5.23 and Fedora 23 with Bluez 5.35

Slave (Raspberry Pi Bluez 5.23 or Fedora 23 Bluez 5.35): 
       #need root access
       sudo su

       #enable 6lowpan over Bluetooth le
       echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enabled

       #start advertising Bluetooth LE service
       hciconfig hci0 leadv
master (Raspberry Pi Bluez 5.23 or Fedora 23 Bluez 5.35):
        #need root access
        sudo su

        #enable 6lowpan over Bluetooth le
        echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable

        #establish le connection to master
        hcitool lecc 5C:F3:70:XX:XX:XX

        echo "connect 5C:F3:70:XX:XX:XX 1" > /sys/kernel/debug/bluetooth/6lowpan_control

Neither one is successful.  When I connect the master to the slave a bt0 device is automatically brought up on the master however the bt0 device does not come up on the slave.  The bt0 device on the master disappears after less than 30 seconds. 

In the logs for the master I see when the bt0 device comes up and then goes down based on the ntpd logs but I do not see any issues with Bluetooth.  On the slave, the only messages I see are :
	Bluetooth:  SMP security requested but not available
	Unable to register GATT service with handle 0x00XX for device  ........
The handles listed are:  0x0009, 0x000c, 0x0010, 0x0011, 0x0014, 0x001a, 0x001f and 0x0028,

I ran hcidump on the slave but I do not see anything in there that would indicate what the issue is.  I did not attach the hcidump to this e-mail because it is 16K in size.  If anyone would like to see the dump, please e-mail me directly and I will send it to you.

I have a feeling I am just missing something on the slave but I cannot find the solution.  I also posted this question to stackoverflow (question closed and resubmitted to superuser here:  http://superuser.com/questions/1025194/bluetooth-6lowpan-connection-between-two-raspberry-pis) 

Any help would really be appreciated.  
Thanks,

