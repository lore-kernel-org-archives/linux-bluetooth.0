Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7592EC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjC3SpO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjC3SpI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:45:08 -0400
X-Greylist: delayed 1740 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 11:45:06 PDT
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D1119
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:45:06 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4PnXR32kDbz9tP8;
        Thu, 30 Mar 2023 20:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
        t=1680201903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrQ5XxL6YIAF9CBvzjdkfpd8cTgU86dCdEX+Htib7Qc=;
        b=SnDP9+9cOxWwPb2eDxSv5VdRdWGyr+lVZWNAygVWwVe1Xo57zAQBPGlCChxyDVAY/7/hX0
        WkDg4t4mH4YPuESWJfpJBOVDfyLfdVl2ScH/R78NIEeyU9DqK95lgrkCwC3uscUOgnWVp3
        uLjlT7pA5qlejQM849LMTpyKm5twX9eLct/zEP4Zti8pI313Knwza/nJWLg2ILyyVsyoUN
        V86FYscBcWG4kS4hAGjJ+ho8lC4VZe/VLEZcMTtiqKmpw2PghyysRS0q9f5g/pqOQ2G3cZ
        48TzWTbYkEk5/UZ/KNRBknAmL5Bcw3Bf+eX8T9ZAS992lpVcFBV7okC0HzQTBw==
Message-ID: <c6192210-62a2-4282-2943-56dae4d9ed7a@tavla.de>
Date:   Thu, 30 Mar 2023 20:45:02 +0200
MIME-Version: 1.0
Subject: Re: How to Automatically Re-Connect Bluetooth HID over GATT (HOG)
 Device when BlueZ Plugin "hog" is Disabled
Content-Language: en-GB
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
 <CABBYNZJMcEX6-9nQgoYccc7W=yEetNjjCMXSzP=Aa-4r4X_puw@mail.gmail.com>
 <56921851-be55-1380-2185-111335edaeb0@tavla.de>
 <96ab0304-09e0-7bd9-944c-09ab03a21b67@tavla.de>
 <CABBYNZ+ydQdL=GhKAMUZ-qqdu=xX+sTxVNJmMWO60=XBLWoTaA@mail.gmail.com>
From:   Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <CABBYNZ+ydQdL=GhKAMUZ-qqdu=xX+sTxVNJmMWO60=XBLWoTaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PnXR32kDbz9tP8
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 30.03.23 um 20:25 schrieb Luiz Augusto von Dentz:
> Hi Martin,
>
> On Thu, Mar 30, 2023 at 11:16 AM Martin Petzold <martin.petzold@tavla.de> wrote:
>> Dear Luiz,
>>
>> I now have another issue with remote control HID integration
>> (non-system; direct implementation).
>>
>> I am using Java with d-bus BlueZ 5.55 on Debian Linux. I have "hid" and
>> "input" plugin disabled on bluetooth startup.
>>
>> I have one remote integrated and working. With this one after boot and
>> while application startup I iterate over all paired devices with
>> existing HID service (check for existing service UUID) and then iterate
>> all Report characteristics and enabling notifying for all of them (if
>> supported). Everything is running well with this (legacy) remote. After
>> pairing it also auto-connects using my own registered object manager, as
>> suggested by you.
>>
>> Now we received our final custom remote control from our manufacturer
>> (other chip) and this approach does not work any more. I have tried a
>> lot of things now. Once the remote control is paired (which is also
>> somehow still buggy) and I rebooted the system with our application, the
>> device is found in the list as paired, BUT I cannot access the HID
>> service any more. Therefore, I cannot enable notifying for this remote.
>>
>> What I realized is, that this remote control seems to have something
>> like MAC address randomization enabled (probably for security reasons).
>> It also does not propagate device information unless I start pairing
>> mode. Because of MAC address randomization it also seems that pairing is
>> buggy - only works sometimes with some special procedure.
>>
>> I know this remote works, because if I connected in manually via
>> bluetoothctl sometimes I works with enabling of notifying. Also directly
>> after pairing it seemed to work.
>>
>> Have you seen something like this before? What should I do?
> It is probably using the privacy (aka Resolvable Private Address/RPA),
> there were quite a few fixes since 5.55 so you might want to update
> your version to the latest to see if pairing works properly, note that
> the D-Bus object might use the RPA address when it is first paired but
> after that if you restart the daemon it will use the Identity Address,
> so the any code using the device objects shall not attempt to store
> and access the object based on their addresses since that can change
> due to these conditions.
Okay, thanks. I will check new version somehow. Unfortunately I cannot 
change Kernel (currently 5.10) because of several drivers, devices and 
patches. I am not sure how to selectively update BlueZ and if this even 
works. Debian package in sid seems to be 5.66, but aren't this only the 
user space tools?

However, my object manager implementation is quite simple / dumb. There 
is no relation to MAC in there (find code below).

Aren't the service and characteristics information stored in the file 
system using the MAC address? This would explain, why they are not found 
after the MAC address randomized.

-----

package technology.tavla.platform.os.runtime.core.system.bluetooth;

import java.util.HashMap;
import java.util.Map;

import org.freedesktop.dbus.DBusPath;
import org.freedesktop.dbus.interfaces.ObjectManager;
import org.freedesktop.dbus.types.Variant;

import 
technology.tavla.platform.os.runtime.common.service.system.bus.BusManager.Bus;
import 
technology.tavla.platform.os.runtime.common.service.system.bus.BusManager.BusException;
import 
technology.tavla.platform.os.runtime.core.system.bluetooth.object.AbstractLocalObject;
import 
technology.tavla.platform.os.runtime.core.system.bluetooth.object.LocalObject;
import 
technology.tavla.platform.os.runtime.core.system.bluetooth.profile.HID;

public class LocalObjectManager extends AbstractLocalObject implements 
ObjectManager {

     private Map<DBusPath, Map<String, Map<String, Variant<?>>>> objects 
= new HashMap<DBusPath, Map<String, Map<String, Variant<?>>>>();

     private Map<String, Map<String, Variant<?>>> properties = new 
HashMap<String, Map<String, Variant<?>>>();

     public LocalObjectManager(final Bus bus) throws BusException {
         super("/" + LocalObjectManager.class.getName().replace(".", "/"));

         bus.exportObject(this.getObjectPath(), this);

         HID profile = new HID();

         this.addObject(profile);

         bus.exportObject(profile.getObjectPath(), profile);
     }

     @Override
     public Map<DBusPath, Map<String, Map<String, Variant<?>>>> 
GetManagedObjects() {
         return this.objects;
     }

     @Override
     public Map<String, Map<String, Variant<?>>> getProperties() {
         return this.properties;
     }

     public <T extends LocalObject> void addObject(T object) {
         this.objects.put(new DBusPath(object.getObjectPath()), 
object.getProperties());
     }

}

-----

package technology.tavla.platform.os.runtime.core.system.bluetooth.profile;

import java.util.HashMap;
import java.util.Map;

import org.bluez.GattProfile1;
import org.freedesktop.dbus.types.Variant;

import 
technology.tavla.platform.os.runtime.common.service.system.bluetooth.BluetoothManager.BluetoothService;

public class HID extends AbstractLocalProfile {

     private Map<String, Map<String, Variant<?>>> properties = new 
HashMap<String, Map<String, Variant<?>>>();

     public HID() {
         super("/" + HID.class.getName().replace(".", "/"));

         Map<String, Variant<?>> map = new HashMap<>();

         map.put("UUIDs", new Variant<>(new String[] {
BluetoothService.Type.HUMAN_INTERFACE_DEVICE.getFullUUID()
         }));

         this.properties.put(GattProfile1.class.getName(), map);
     }

     @Override
     public void Release() {
         // TODO Auto-generated method stub

     }

     @Override
     public <A> A Get(String interfaceName, String key) {
         //return this.properties.get(interfaceName).get(key);
         return null;
     }

     @Override
     public <A> void Set(String interfaceName, String key, A value) {

     }

     @Override
     public Map<String, Variant<?>> GetAll(String interfaceName) {
         return this.properties.get(interfaceName);
     }

     @Override
     public Map<String, Map<String, Variant<?>>> getProperties() {
         return this.properties;
     }

}

-----

Best regards,

Martin

