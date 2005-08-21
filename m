Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43087A88.4030306@gmx.net>
From: Whoopie <whoopie79@gmx.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------090602050207080701020604"
Subject: [Bluez-devel] Re: btsco - a few comments and a small .py script
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 21 Aug 2005 14:58:48 +0200

This is a multi-part message in MIME format.
--------------090602050207080701020604
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
great work, Andreas! Thanks!

I did a small modification so that you can also finish the call if the 
call is in progress.

Thanks again,
Whoopie

--------------090602050207080701020604
Content-Type: text/x-python;
 name="skype_pickup.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="skype_pickup.py"

#! /usr/bin/python
# -*- coding: iso-8859-15 -*- 

import dbus, sys

class Api_obj:
	def __init__(self):
		remote_bus = dbus.SystemBus()
		
		system_service_list = remote_bus.get_service('org.freedesktop.DBus').get_object('/org/freedesktop/DBus', 'org.freedesktop.DBus').ListServices()
		skype_api_found = 0

		for service in system_service_list:
			if service=='com.Skype.API':
				skype_api_found = 1
				break

		if not skype_api_found:
			sys.exit('No running API-capable Skype found')

		skype_service = remote_bus.get_service('com.Skype.API')
		self.skype_api_object = skype_service.get_object('/com/Skype','com.Skype.API')

		answer = self.send_message('NAME SkypeApiPythonBluetoothHeadset')
		if answer != 'OK':
			sys.exit('Could not bind to Skype client')

		answer = self.send_message('PROTOCOL 1')
#		if answer != 'PROTOCOL 1':
#			sys.exit('This test program only supports Skype API protocol version 1')

		answer = self.send_message('SEARCH ACTIVECALLS')
		answer = answer[6:]
		status = self.send_message('GET CALL '+answer+' STATUS')
		status = status[15:]
		if status == 'INPROGRESS':
			answer = self.send_message('SET CALL '+answer+' STATUS FINISHED')
		else:
			answer = self.send_message('SET CALL '+answer+' STATUS INPROGRESS')

	# Client -> Skype
	def send_message(self, message):		
		answer = self.skype_api_object.Invoke(message)
		return answer

def main():
	api_object = Api_obj()
	return 0	

if __name__ == "__main__":
	main()

--------------090602050207080701020604--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
