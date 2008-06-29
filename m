Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 30 Jun 2008 00:22:18 +0800
MIME-Version: 1.0
Message-Id: <200806300022.18249.Jerry87905@gmail.com>
From: Li Dongyang <jerry87905@gmail.com>
Subject: [Bluez-devel] [GSoC2008]bluez-python status
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

hi, everyone,
  This is Li Dongyang working on bluez-python as a GSoC 2008 project.
  Now I'm at home and just pushed Agent to gitorious.
  The git repo is here: http://gitorious.org/projects/bluez-python
  and the wiki page is here: http://wiki.bluez.org/wiki/bluez-python
  I update the wiki after every change.
  so far we have done:
  Manager, Adapter, Device and Agent classes according to the BlueZ 4.0 API.
  every class(except Agent) have a method HandleSignal(handler, signal) to 
make you deal with spec signals with your own handler.

Manager:
  The Manager is a singleton since many managers won't make sense, If you 
wanna have mainloop support, you should pass an arg to Manager's __init__ 
describing which mainloop you wanna have, like "manager = 
bluez.Manager('gobject')" will have gobject support. Mainloops supported 
currently are 'gobject', 'pyqt4' and 'ecore'.
  Manager have a method  called GetAdapter(pattern=None), if the pattern is 
None by default, it will call the DefaultAdapter() on the bluez dbus 
interface, init an instance of Adapter with the return value(object path of 
the default adapter), then return the Adapter instance. Otherwise it will 
call FindAdapter(pattern). the pattern could be 'hci0' 
or "00:11:22:33:44:55".
 and the ListAdapter() return a list of Agent instances, not object paths.
also a CreateAgent() for Agent usage, more details in the Agent section.

Adapter:
  The methods return instance of Device instead of object path, also some 
require instance of Device or Agent instead of object path, others act same 
as doc/adapter-api.txt

Device:
  add one more method GetObjectPath() to return object path. others same as 
doc/device-api.txt

Agent:
  add one more method GetObjectPath(), same as Device's
  by default the Agent acts as hcid/simple-agent, you can inherit the Agent 
and use AgentMethod decorator to define your own agent.
  The CreateAgent(cls=Agent, obj_path='/org/bluez/Agent') of Manager is used 
to init an agent, please notice the agent need mainloop support to init.
  if you call CreateAgent() without args, it will give you the default Agent 
instance and the object path is '/org/bluez/Agent'. if you wanna define your 
own agent, you can do as follows:

import bluez
import gobject

class my_agent(bluez.Agent):
    @bluez.AgentMethod
    def ConfirmModeChange(self, mode):
          print mode

manager = bluez.Manager('gobject')
adapter = manager.GetAdapter()
agent = manager.CreateAgent(my_agent)
adapter.RegisterAgent(agent)
mainloop = gobject.MainLoop()
try:
    mainloop.run()
except KeyboardInterrupt:
    mainloop.quit()

This example can make my_agent, and just overwrite the ConfirmModeChange() 
method.
If you wish to overwrite agent method with async_callbacks, just do this:

class my_agent(bluez.Agent):
    @AgentMethod
    def ConfirmModeChange(self, mode, success_callback, error_callback)

and AgentMethod will check the arg of the method with inspect module, if the 
len(arg) is 3 more than the in-signature(including the 'self'), it will build 
up async_callbacks tuple and pass it to decorator dbus.service.method, that's 
how the async_callbacks works.

If you have better ideas, or feed back, please do contact me, your suggestions 
are really very important. Thanks in advance!
You can reach me at: Jerry87905@gmail.com
or missed at irc.freenode.org

ps: The ISP I use at home always reset my connection to freenode every 3-5 
minutes, so the best way is to mail me.
Cheers,
Li Dongyang

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
