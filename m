Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <trinity-669c071f-e705-4b76-94c2-ba1fdd93d1ad-1505551992168@3c-app-gmx-bs02>
References: <trinity-669c071f-e705-4b76-94c2-ba1fdd93d1ad-1505551992168@3c-app-gmx-bs02>
From: Laczen JMS <laczenjms@gmail.com>
Date: Sat, 16 Sep 2017 11:51:23 +0200
Message-ID: <CAFxSrVugMUdrJqgTobr+tc_SQp93UQRXWrKLVDk1V8vJmqkyJQ@mail.gmail.com>
Subject: Re: Meshctl beginner
To: "Zabel, Oliver" <oliverzabel@gmx.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

I don't have any experience on the rpi zero w, but I managed to start
using meshctl on my laptop using a bluetooth dongle (my build-in
dongle did not work). My nodes are not silicon labs based but nrf51
using zephyr).

I didn't have to change anything to the json files. But some advice:

1. Make sure bluetoothd is version 5.46 (latest from github): check
this by running bluetoothd -v. If it gives a lower version do a google
search on how to install bluez from source. When compiling don't
forget the option enable-mesh.

2. Make sure the correct bluetooth device is used, if you have more
than one, select the right device using [meshctl]# select ...

3. After the right device is selected run: [meshct]#
discover-unprovisioned on, this should show your node with a number
aabb...

4. Provision the node: [meshctl]# provision aabb000000000000, you can
remove any trailing zeros if there are

5. Provisioning can fail when the security is set to high (this means
that your node is using a unsecure way of provisioning, and you should
change the node's software), however you can change the security for
testing by recompiling or in the latest version with the command
[meshctl]#security ...

6. If the node is provisioned you need to configure it, I assume that
you are trying to configure a onoff-server (0100 below is the mesh
address):
    a. [... Mesh-Node-0100]#  configure 0100
    b. [config: Target =3D 0100]# add-appkey 1 (the onoff client defined
in the JSON files is using appkey 1)
    c. [config: Target =3D 0100]# bind 0 1 1000 (bind the appkey to the
server model, 1000 is the server model)
    d. [config: Target =3D 0100]# back

7. You can now control your onoff server using the onoffclient:
     a. [... Mesh-Node-0100]# onoff 0100
     b. [on/off: Target =3D 0100] # onoff 0 -> switch server off
     ...

I hope this can get you on the right track.

Kind regards,

Jehudi

2017-09-16 10:53 GMT+02:00 Zabel, Oliver <oliverzabel@gmx.de>:
> Hi,
>
> I would linke to start experimenting with Bluetooth mesh. Therefor i trie=
d to find some hints howto configure/start with meshctl to start provisioni=
ng. I am using a raspberry pi Zero w together with a Silicon Labs mesh Star=
ter Kit but meshctl dose not even find any Controller.
>
> Question: can someone Provide a Short introduction howto use meshctl? Esp=
ecially how to Setup the both json Files. I think everyone who wants to sta=
rt with mesh would be thankful. Perhaps i can collect some Information and =
Provide them on StackOverflow or somewhere Else.
>
>
> Tanks for your help!
> Have a Nice Weekend
>
> Oliver
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
